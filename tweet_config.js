var tweet_config = {};

tweet_config.queryString = "$BTC OR $ETH OR $DOGE OR $ADA";
tweet_config.fromDate = "202207010000";
tweet_config.toDate= "202208010000a";
tweet_config.maxResults = 500;
tweet_config.returnOnly = 10000;

module.exports = tweet_config;