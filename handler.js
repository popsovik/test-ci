module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE for plugin!!!! - Version 9!'
  };

  callback(null, response);
};