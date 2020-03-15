const router = require('express').Router();
const credit = require('../controllers/credit.js');


router.post('/insert', 
  credit.validate('insert'), 
  function (req, res) {
    credit.insert(req, res) 
})

module.exports = router
