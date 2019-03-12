module.exports.hello = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: 'EXAMPLE for script!!!! - Version 7!'
  };

  callback(null, response);
};