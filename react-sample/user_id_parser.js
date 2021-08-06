const csv = require('csv-parser')
const fs = require('fs')
const results = [];
const { groupBy } = require('lodash')
const faker = require('faker');

# here's a comment
fs.createReadStream('./user_ids.csv')
  .pipe(csv())
  .on('data', (data) => results.push(data))
  .on('end', () => {
    const grouped = groupBy(results, (elem) => {return elem['user_id']});
    const keys = Object.keys(grouped)
    const output = keys.map((elem) => {
      return {
        name: faker.fake("{{name.lastName}} {{name.firstName}}"),
        userId: elem,
        dataset: elem[0] === 'a' ? "liberty_lending" : "carefull"
      }
    })
    const json = JSON.stringify(output);

    fs.writeFileSync( 'users.json', json )

    const carefull_dataset = output.filter((element) => {
    return element.dataset === 'carefull'
  })

  fs.writeFileSync( 'careful.json', JSON.stringify(carefull_dataset) )

  const ll_dataset = output.filter((element) => {
    console.log('====================================');
    console.log(element);
    console.log('====================================');
    return element.dataset === 'liberty_lending'
  })
fs.writeFileSync( 'll.json', JSON.stringify(ll_dataset) )


  });

  
  
