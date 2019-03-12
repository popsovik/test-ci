module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE!!!! - Version 4!'
  };

  callback(null, response);
};