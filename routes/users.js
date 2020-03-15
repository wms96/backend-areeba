const router = require('express').Router();
const users = require('../controllers/users.js');


router.post('/register', 
  users.validate('register'), 
  function (req, res) {
  users.register(req, res) 
})

router.post('/login',
  users.validate('login'), 
  function (req, res) {
  users.login(req, res) 
})

router.post('/jwtValidator', 
  function (req, res) {
  users.jwtValidator(req, res) 
})


router.post('/resetPassword', 
  users.validate('resetPassword'), 
  function (req, res) {
  users.resetPassword(req, res) 
})

router.get('/getAuth', 
  function (req, res) {
  users.getAuth(req, res) 
})

router.post('/getVirtualCard', 
  function (req, res) {
  users.getVirtualCard(req, res);
})

router.post('/saveVirtualCard', 
  function (req, res) {
  users.saveVirtualCard(req, res);
})


router.post('/creditHistory', 
  function (req, res) {
  users.creditHistory(req, res);
})

module.exports = router
