const bcrypt = require('bcryptjs');
const twilio = require('twilio');
const jwt = require('jsonwebtoken');
const { body } = require('express-validator/check');
const { validationResult } = require('express-validator/check');

const saltRounds = bcrypt.genSaltSync(10);
const accountSid = 'ACffc2cd339005456702aef4862e4f52f6'; // Your Account SID from www.twilio.com/console
const authToken = 'f2ea12d9dd1c8033839f70872b949d7f';   // Your Auth Token from www.twilio.com/console

const client = new twilio(accountSid, authToken);

const connection = require('../config/database.js');
const users = require('./users.js');

const request = require('request');

var https = require('follow-redirects').https;
var fs = require('fs');

module.exports.register = (req, res) => {

  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(422).json({ errors: errors.array() })
  }
  user = req.body;

  connection.query('SELECT first_name FROM users WHERE phone_number = ? ', user.phone_number, function (error, results, fields) {
    try {
      console.log('error ', error);
      if (error) res.json({ status: 0, message: error });
      if (!results.length) {
        const passwordHash = bcrypt.hashSync(user.password, saltRounds);
        const CURRENT_TIMESTAMP = { toSqlString: function () { return 'CURRENT_TIMESTAMP()'; } };
        user.password = passwordHash;
        const randomCode = Math.random().toString(36).substring(7) + CURRENT_TIMESTAMP;
        const qrRefHash = bcrypt.hashSync(randomCode, saltRounds);
        user.qr_ref = qrRefHash;
        user.created_at = CURRENT_TIMESTAMP;
        connection.query('INSERT INTO users SET ?', user, function (error, results, fields) {
          if (error) res.json({ status: 0, message: error });
          console.log('results ', results)
          res.json({ status: 1, message: "Account Create" })
        });
      } else {
        res.json({ status: 0, message: "account already exists" })
      }
    } catch (error) {
      res.json({ status: 0, message: error })
    }

  });
}

module.exports.login = (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(422).json({ errors: errors.array() })
  }
  user = req.body;
  connection.query('SELECT * FROM users WHERE phone_number = ? ', user.phone_number, function (error, usersData, fields) {
    if (error) throw error;
    if (usersData.length == 0) res.json({ status: 0, message: "username or password are incorrect" });
    if (bcrypt.compareSync(user.password, usersData[0].password)) {
      connection.query('UPDATE users SET last_login = NOW() WHERE phone_number = ?', [user.phone_number], function (error, results, fields) {
        if (error) throw error;
        let payload = { subject: user.phone_number };
        let token = jwt.sign(payload, 'sercret');
        res.json({ status: 1, token: token, results: usersData[0] });
      })
    } else {
      res.json({ status: 0, message: "username or password are incorrect" });
    }
  })
}

module.exports.jwtValidator = (req, res) => {
  user = req.body;
  jwt.verify(user.token, 'sercret', function(err, decoded) {
    console.log(decoded.foo); // bar
  });
}

module.exports.resetPassword = (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(422).json({ errors: errors.array() })
  }
  user = req.body;

  let randomCode = Math.random().toString(36).substring(8);
  const hash = bcrypt.hashSync(randomCode, saltRounds);
  connection.query('UPDATE users SET password = ? WHERE phone_number = ?', [hash, user.phone_number], function (error, results, fields) {
    if (error) throw error;
    if (results.affectedRows > 0) {
      client.messages.create({
        body: 'Use the Following Code to reset your Password: ' + randomCode,
        from: '+15015005084',
        to: '+96171035881'
      }).then(() => {
        res.json({ status: 1, message: "Reset Password Sent" })
      })
    } else {
      res.json({ status: 0, message: "Reset Password failed" })
    }
  });
}

exports.getAuth = (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(422).json({ errors: errors.array() })
  }
  user = req.body;

  var options = {
    'method': 'POST',
    'url': 'https://api.areeba.com/oauth2/token',
    'headers': {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic TjJndmVGTUxJTjhEa1I2VVNHZVZtdUV2d2NFYTpQaDRla3pJUmxGWmdJOFVqalFLQnhyc1Y1NW9h'
    },
    form: {
      'grant_type': 'client_credentials'
    }
  };
  request(options, function (error, response) {
    if (error) throw new Error(error);
    console.log('user ', user);
    res.json(response.body)
  });

}


exports.getVirtualCard = (req, response) => {


  console.log('dadada');

  var options = {
    'method': 'POST',
    'hostname': 'api.areeba.com',
    'path': '/cms1/cards/virtual',
    'headers': {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.areeba.cms+json; version=1.0',
      'Authorization': 'Bearer ' + req.body.token
    },
    'maxRedirects': 20
  };

  var req = https.request(options, function (res) {
    var chunks = [];
    console.log('dadada');

    res.on("data", function (chunk) {
      chunks.push(chunk);
    });

    res.on("end", function (chunk)  {
      var responseBody = Buffer.concat(chunks);
      console.log(responseBody.toString());
       responseBody = JSON.parse(responseBody.toString());
      return response.json(responseBody)
    }.bind(response)
    );

    res.on("error", function (error) {
      console.error(error);
    });
  });
  var postData = JSON.stringify({ "firstName": "Super", "lastName": "Man", "clientId": "115870", "bankId": "157856685855", "contractProductType": "MCPRPVIRTUSD", "cardProductType": "MCPRPVIRT" });

  req.write(postData);

  req.end();
  return req;
}

exports.saveVirtualCard = (req, res) => {
  user = req.body;
  connection.query('INSERT INTO card_information SET ?', user, function (error, results, fields) {
    if (error) throw error;
    res.json({ status: 1, message: "Saved Sent" })
  });   
}


exports.creditHistory = (req, res) => {
  user = req.body;

  connection.query('SELECT credit.amount, CONCAT(users.first_name, " ", users.last_name) AS debiter, credit.created_at FROM credit INNER JOIN users ON users.id = credit.transaction WHERE credit.client_id = ?',user.id , function (error, results, fields) {
    if (error) throw error;
    res.json({ status: 1, item:results })
  });   
}

exports.validate = (method) => {
  switch (method) {
    case 'register': {
      return [
        body('first_name', "first name doesn't exists").exists(),
        body('last_name', "last name doesn't exists").exists(),
        body('email', "email doesn't exists").exists().isEmail(),
        body('phone_number', "phone number doesn't exists").exists(),
        body('password', "phone number doesn't exists").exists().isLength({ min: 5 }),
      ]
    }
    case 'login': {
      return [
        body('phone_number', "phone number doesn't exists").exists(),
        body('password', "password doesn't exists").exists(),
      ]
    }
    case 'resetPassword': {
      return [
        body('phone_number', "phone number doesn't exists").exists(),
      ]
    }
  }
}