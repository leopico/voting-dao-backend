# Voting DAO dapp with demo

This pj was demo voting dao with hardhad framework.Then already testing on [Remix](http://remix.ethereum.org).

- You have to clone this repo.
```shell
https://github.com/leopico/voting-dao-backend.git
```

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`RPC_URL`

`PRIVATE_KY`

`ETHERSCAN_API_KEY`

## Install depencies

```shell
npm install
```

```shell
npx hardhat compile
npx hardhat run scripts/deploy.js --network goerli
npx hardhat verify  --network -goerli DEPLOYED_CONTRACT_ADDRESS
```


## Demo

- You have to build front_end folder inside your hardhat backend pj. [front_end github link](https://github.com/leopico/voting-dao-frontend.git). Because of I linked for solidity abi-code with front_end folder.You can see on hardhat.config.js.And also you have to check ReadMe.md of frontend side.



[deployed on vercel for frontend]().

## Acknowledgements

 - [Hardhat documentation](https://hardhat.org/).
 - [Solidity](https://soliditylang.org/).

## Tech Stack

**Server:** Solidity, Hardhat

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Badges

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
