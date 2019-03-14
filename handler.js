module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE new branch!!!! - Version 17!'
  };

  callback(null, response);
};