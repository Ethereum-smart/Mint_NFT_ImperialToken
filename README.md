# TokenURI valido
- validar la estructura que nos ofrece OpenSea para adjuntar nuestro JSON correcto
- ejecutar contrato sin despliegue `npx hardhat run scripts/run.js`
```
  { 
    "name":"Tommy",
    "description":"my dog",
    "image":"https://i.imgur.com/xCHmg5w.jpg"
  }
```

# Deploy contract
- configurar el archivo hardhat.config.js
- en nuestro caso el contrato lo desplegamos en la red de Rinkeby
```
  module.exports = {
    solidity: "0.8.4",
    networks: {
      rinkeby: {
        url: process.env.ALCHEMY_API_KEY_URL,
        accounts: [process.env.RINKEBY_PRIVATE_KEY],
      },
    },
  };
```
- y finalmente ejecutamos `npx hardhat run scripts/deploy.js --network rinkeby`