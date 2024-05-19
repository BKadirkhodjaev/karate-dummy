function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('=== ENV: ', env, " ===");

  if (!env) {
    env = 'dev';
  }

  var config = {
    env: env,
    myVarName: 'someValue'
  }

  if (env == 'dev') {
    config.baseUrl = 'https://jsonplaceholder.typicode.com'
  } else if (env == 'e2e') {
    // customize
  }

  karate.log('=== Config: ', config, " ===");

  return config;
}