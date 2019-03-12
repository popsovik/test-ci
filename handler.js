module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE!!!! - Version 2!'
  };

  callback(null, response);
};