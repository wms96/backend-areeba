const express = require('express');
const expressValidator = require('express-validator')

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(expressValidator())


app.use(function(req, res, next) {
  res.header('Access-Control-Allow-Origin', "*");
  res.header('Access-Control-Allow-Methods','GET,PUT,POST,DELETE');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

//Routes
app.use('/users', require('./routes/users.js'));
app.use('/debit', require('./routes/debit.js'));
app.use('/credit', require('./routes/credit.js'));


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
