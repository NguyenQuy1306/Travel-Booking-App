const jwt = require('jsonwebtoken')

module.exports = function authenticateToken(req, res, next) {
  const token = req.body.token;
  if (!token) return res.status(401).send({ message: 'Token không tồn tại' })
  jwt.verify(token, 'alo1234', (err, decoded) => {
    if (err) return res.res.status(401).send({ message: 'Bạn không có quyền lấy thông tin trang này' })
    req.data = decoded
    next();
  });
} 