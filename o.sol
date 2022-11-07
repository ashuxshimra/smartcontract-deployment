//Synchronous -> Solidity is a synchronous that is code executed line by line
// ASynchronous -> Javascript is ASynchronous by default that is vice versa of it

//Example of cooking of popcorn
//Synchronous
// 1. Put the popcorn in microwave
// 2. Wait for popcorn to finish
// 3. Pour drinks for everyone

// ASynchronous
// 1. Put the popcorn in microwave -> functions that have waiting period is called Promise that is promise based function
// 2. Pour drinks for everyone
// 3. Wait for popcorn to finish

// Promise can be :
// pending - so waiting for popcorn to finish is the pending state
// fulfilled - and when popcorn finsihed then promise will gave fulfilled state
// rejected - if in half way we abort the process then it is rejected state

const ethers= require("ethers"); //importing ether package so that it could be used and storing in the ether variable of const type
const fs= require("fs"); //this too is a package which is lke a object used to access and read files as shown in below code , install first by "yarn add fs"
async function main() {
  //all of our contract code and stuff will go inside the main function
  //note that to compile our contract, we will use solc which is basically a package used to compile sc in code editor such as vsc and hence use yarn or npm package manager to install solc package so here lets use yarn as : yarn add solc@0.8.7-fixed because we are writing solidity contract version 0.8.7 so for it to be compatible with solc doing it, note in terminal write corepack enable and then yarn will be installed so now use yarn
  //also in this folder you have installed solc and so  no worries but so take care of it when u need to compile the sc , or globally as well the solc can be installed as per the commands
  // you can type "yarn solcjs --help" and details of options will be displayed so acc you can create a script under dependencies for compile so that when in terminal typed compile it will take care of all this options so see page 40 and till page 42-43, u get everything
  // to compile the contracts you can go to terminal and type yarn compile after adding the dependency in package.json -> adding what to run when typed 'compile' just see 6.53.0 for doubts
  //and now to deploy this contract on a blockchain network we need a fake blockchain network , so we can use a test environment called as ganache which provides fake accounts using which u can deploy the contract on this fake ganache blockchain network we also have rpc url which is bascially a url for these fake networks see page 44
  // http://127.0.0.1:7545 -> hence using this url we can make api calls and like interact with the network node
  // so to interact with the node or even deploy and stuff here ether js comes into play. hence using this we can depploy the contract to bc network or also ganche fake network as well by writing suitable deploy command also to install the ether.js package go to terminal and "yarn add ethers" and hence once the installation is done you can go to the dependencies where the packages are installed and u can see that ether.js is present along with version just like solc
  // now to deploy our contract on a blockchain network(here ganache with the help of rpc url) we can use ether package and thus for that import the ether package as done at the top and thus this is how the script is always that is always the import of packages at top , main function in betweem and then the calling part where error code was done at the bottom
  //console.log("hi"); //to run this using node , go to terminal and type "node deploy.js" that is name of file and press enter this way it will run js code in backend
  //let variable = 8;
  //console.log(variable);


  //now as the packages suitable are imported you can use them to go ahead and deploy the contrac
  const provider=new ethers.providers.JsonRpcProvider("http://127.0.0.1:7545"); //this is line to get the provider blockchaain network where contract will be deployyed and thus in brackets we paste the rpc ganache network url on which the contract will be deployed and storing in the variable provider of const type
  //now we need the wallet that is the account from which we will take fee to deploy this contract and so we get that by selecting one of the fake account of ganache and copying its private key and thus pasting in the below line for getting the wallet for deployment
  const wallet= new ethers.Wallet("fc713ffc40de4495ff41b18e20db79307b4ea1ef10ba46cf0c12cdb1e9a19894" , provider); //line for getting the wallet from which money will be charged to deploy on a blockchain network provider and so ", provider" as well
//hence ethers package used for which network to deploy and from which account to deploying , hence so clear now


//hence now to start deployment of contract since we have the bc n/w and the wallet , abi and binary form (encoded) of contract is needed so we will get them from the compilation deltails as we got after compiling this sc from the files created for it so reading from them as :
const abi= fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8"); //hence with the help fs we read the file synchrounously from ("location as done that is from ***.abi file") in order to get the abi of the compiled sc and also adding "utf8" which is like used for encoding this abi and thats all just add and storing it in abi variable
//similarly we get the binary code of contract as well :
const binary= fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf8"); //storing the binary code by reading from the compiled file after compilation of contract using solc in the binary variable

//now we have everything so in ethers package we have a object named contractFactory which is used to deploy the contract so:
const contractFactory= new ethers.ContractFactory(abi , binary , wallet); //so passing it all to the object contractfactory and storing in contractFactory variable and now this variable has abi and binary for deployment and wallet as well for signing the transaction hence deploy as :
console.log("Deploying contract , please wait........");
const contract= await contractFactory.deploy(); //await keyword as deploying sc takes bit time and so for it to work smooth need to add this so that deployment is successful and then we can move forward , also storing the deployed contract in the contract variable
console.log(contract);  //now lets run this and see the deployment and thus go to terminal and write node deploy.js to run this code.
// hence wrote a sc and then separately compiled it using the solc , by which got the files specifying its abi and the binary code of the contract that is the compilation details , and then using the ethers package to get the network rpc where sc to be deployed and then the wallet from which the transaction will be signed and then the using the contractFactory object kept everything and then deployed by await 
// once the contract is deployed you will see the output which will give us the chain id, gas, block number , from which account fee charged to deploy , hash-id etc etc and when u notice that the account used from ganache has some money deducted which was used to sign transaction in order to deploy see page-45-47 for o/p of deployed contract 

//now to get the receipts of transaction and receipts of deployment , note that you get transaction receipt only when you get the confirmation that block is attached to chain by waiting for one more block and you always get the deployment transactioin whenever u perform it so:
// note that binary code of sc is like the sc but represented in the form of code
const transactionReceipt= await contract.deployTransaction.wait(1);//that is waiting deployTransaction of the deployed contract by one more block 
// console.log("This is the deploy transaction receipt")
// console.log(deployTransaction);
// console.log("This is the transaction receipt");
// console.log(transactionReceipt);

}
main()
  .then(() => process.exit(0)) //since our main function is async we and while calling in order to wait and print if there is any error it gets , we have used this code just copied and pasted
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

//Set up Movie night
// a)cook popcorn
// b)pour drinks
// c)start movie

//so we make the function for above and a and b has to finsih then only we can start movie hence a and b are waiting functions that is promise has to be returned from them whether fulfilled or rejected that is await for them first and then move on
//so we will use a lot of async function where we will await for a statement say while deploying sc we have to await otherwise even before it being deployed , if it goes further then code wont work
async function setupMovienight() {
  await cookPopcorn(); //this await implies it is calling a waiting function that a function which will take time and return a promise that is fulfilled or rejected and then move on to the next line
  await pourDrinks();
  startMovie(); //now after finishing the above functions only we can start the movie
}
//when we deploy a sc ? wait for it to be deployed
function cookPopcorn() {
  // some code here
  return Promise(/*some code here*/);
}

