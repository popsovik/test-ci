module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'Wait, it is Serverless v1.29.3333!'
  };

  callback(null, response);
};