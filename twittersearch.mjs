import fetch from 'node-fetch';
import * as pg from 'pg';
import config from './config.js';
import tweet_config from './tweet_config.js';

const { Client } = pg.default;
const connectionString = config.connectionString

const client = new Client({
    connectionString,
    ssl: {
        rejectUnauthorized: false
    }
})
client.connect()

let twitterURL = config.twitterURL + '?query=' + tweet_config.queryString + "&fromDate=" + tweet_config.fromDate + "&toDate=" + tweet_config.toDate + "&maxResults=" + tweet_config.maxResults
var nextToken

function checkResponse(res) {
    if (res.ok) {
        return res
    } else {
        throw new Error(`HTTP status of the reponse: ${res.status} (${res.statusText})`)
    }
}

fetch(twitterURL, {
        method: 'GET',
        headers: {
            'Authorization': 'Basic ' + Buffer.from(config.username + ':' + config.password).toString('base64')
        }
    })
    .then(checkResponse)
    .then(res => res.json())
    .then(json => {

        let i = 0;
        while (i < tweet_config.maxResults) {
            let tweetObject = json.results[i]
            const text = 'INSERT INTO tweets(tweet_json) VALUES($1) RETURNING *'
            const values = [tweetObject]
            client
                .query(text, values)
                .then(res => {
                    //console.log(res.rows[0])
                })
                .catch(e => console.error(e.stack))
            i++
        }

        nextToken = json.next
        return nextToken

    })
    .then(async nextToken => {

            var tweetCounter = tweet_config.returnOnly - tweet_config.maxResults
            var totalTweets = tweet_config.maxResults
            var resultLength = 0

            if (typeof nextToken !== 'undefined') {
                do {
                    let tokenURL = config.twitterURL + '?query=' + tweet_config.queryString + "&fromDate=" + tweet_config.fromDate + "&toDate=" + tweet_config.toDate + "&maxResults=" + tweet_config.maxResults + "&next=" + nextToken
                    const res = await fetch(tokenURL, {
                        method: 'get',
                        headers: {
                            'Authorization': 'Basic ' + Buffer.from(config.username + ':' + config.password).toString('base64')
                        }
                    });
                    var json = await res.json();

                    let i = 0;
                    while (i < tweet_config.maxResults) {
                        let tweetObject = json.results[i]
                        const text = 'INSERT INTO tweets(tweet_json) VALUES($1) RETURNING *'
                        const values = [tweetObject]
                        client
                            .query(text, values)
                            .then(res => {
                                //console.log(res.rows[0])
                            })
                            .catch(e => console.error(e.stack))

                        i++
                    }
                    resultLength = json.results.length
                    totalTweets += resultLength
                    nextToken = json.next
                    tweetCounter -= resultLength

                    if (tweetCounter <= 0) {
                        break;
                    }
                }
                while (nextToken)
            }
        }
    )
    .catch(err => console.log(err))