const { body } = require('express-validator/check');
const { validationResult } = require('express-validator/check');
const connection = require('../config/database.js');

module.exports.insert = (req, res) => {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() })
    }
    debit = req.body;
    const CURRENT_TIMESTAMP = { toSqlString: function () { return 'CURRENT_TIMESTAMP()'; } };
    debit.created_at = CURRENT_TIMESTAMP;
    connection.query('INSERT INTO debit SET ?', debit, function (error, results, fields) {
        if (error) res.json({ status: 0, message: error });
        console.log('results ', results)
        res.json({ status: 1, message: "Transaction Added", transaction: results.insertId})
    });
}

module.exports.sendTransaction = (req, res) => {
    var https = require('follow-redirects').https;
    var fs = require('fs');
    
    var options = {
      'method': 'POST',
      'hostname': 'api.areeba.com',
      'path': '/transfer/hackathon/pay',
      'headers': {
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.areeba.request+json; version=2.0',
        'Authorization': 'Bearer '+req.body.token
      },
      'maxRedirects': 20
    };
    
    var req = https.request(options, function (res) {
      var chunks = [];
    
      res.on("data", function (chunk) {
        chunks.push(chunk);
      });
    
      res.on("end", function (chunk) {
        var body = Buffer.concat(chunks);
        console.log('body ',body)
        res.json(body)
    }.bind(res)
      );
    
      res.on("error", function (error) {
        console.error(error);
      });
    });
    
    var postData = JSON.stringify({"merchantId":"TEST222204858001","apiPassword":"60f2e352f77cb65ae57d05c2191a27e9","amount":req.body.amount,"currency":"USD","cardNumber":req.body.cardNumber,"cardName":req.body.cardName,"cardCVV":req.body.cardCVV,"expiryMM": req.body.expiryMM,"expiryYY":req.body.expiryYY});
    
    req.write(postData);
    
    req.end();
}


exports.validate = (method) => {
    switch (method) {
        case 'insert': {
            return [
                body('client_id', "client id doesn't exists").exists().isLength({ min: 1 }),
                body('amount', "amount doesn't exists").exists().isLength({ min: 1 }),
                body('details', "details doesn't exists").exists(),
            ]
        }
    }
}