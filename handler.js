module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE new branch!!!! - Version 7!'
  };

  callback(null, response);
};