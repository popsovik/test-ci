module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE!!!! - Version 6!'
  };

  callback(null, response);
};