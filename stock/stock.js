const repository = require('./repository');
let stock = 0;

const init = () => {
  repository.read()
    .then((result) => { stock = result })
    .catch(console.log)
}

const takeOne = () => {
  if (stock > 0) {
    stock--;
    return repository.save(stock).then(true);
  }

  return Promise.resolve(false);
}

const addOne = () => {
  stock++;
  return repository.save(stock);
}

const currentValue = () => {
  return repository.read();
}

init();

module.exports = {
  takeOne,
  addOne,
  currentValue
}