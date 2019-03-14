module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE new branch2!!!! - Version 31!'
  };

  callback(null, response);
};