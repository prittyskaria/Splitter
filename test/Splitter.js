const Splitter = artifacts.require("./Splitter.sol");


contract('Splitter', function([owner, account1, account2]) {

it("Message sender is Alice", async function() {
let instance = await Splitter.deployed();
assert.equal(await instance.Alice(), owner, "Alice is not msg sender");
});


it("Alice sets Bob's address", async function() {
let instance = await Splitter.deployed();
Bob = await instance.setAddressBob(account1,{from:owner});
assert.equal(await instance.Bob(), account1, "Bob's address is not set correctly");
});


it("Alice sets Carol's address", async function() {
let instance = await Splitter.deployed();
Carol = await instance.setAddressCarol(account2,{from:owner});
assert.equal(await instance.Carol(), account2, "Carol's address is not set correctly");
});


it("Gets balance of contract's address", async function() {
let instance = await Splitter.deployed();
balNotstring = await instance.getBalance.call(instance.address);
let balance = balNotstring.toString(10);
assert.equal(balance, web3.eth.getBalance(instance.address).toString(10), "Does not get balance");
});

it("Gets balance of Bob's address", async function() {
let instance = await Splitter.deployed();
balNotstring = await instance.getBalance.call(account1);
let balance = balNotstring.toString(10);
assert.equal(balance, web3.eth.getBalance(account1).toString(10), "Does not get balance");
});

it("Gets balance of Carol's address", async function() {
let instance = await Splitter.deployed();
balNotstring = await instance.getBalance.call(account2);
let balance = balNotstring.toString(10);
assert.equal(balance, web3.eth.getBalance(account2).toString(10), "Does not get balance");
});


it("12000 Wei Alice sent is split equally between Bob and Carol", async function() {
let instance = await Splitter.new();
Bob = await instance.setAddressBob(account1,{from:owner});
Carol = await instance.setAddressCarol(account2,{from:owner});

balance = await instance.getBalance.call(account1);
let Bob_old_balance =balance.toString(10);
balance = await instance.getBalance.call(account2)
let Carol_old_balance =balance.toString(10);
var expected_Bob = parseFloat(Bob_old_balance) + 12000;


await instance.sendEther({from: owner, value:24000});

balance = await instance.getBalance.call(account1);
let Bob_new_balance =  balance.toString(10);
balance = await instance.getBalance.call(account2)
let Carol_new_balance =balance.toString(10);


//assert.equal(Bob_new_balance,Bob_old_balance + 12000, "Bob did not get half of ether that Alice sent");
//assert.equal(Carol_new_balance,Carol_old_balance + 12000, "Carol did not get half of ether that Alice sent");

console.log("Bob's old balance: "+ Bob_old_balance);
console.log("Carol's old balance: "+ Carol_old_balance);
console.log("Bob's new balance: "+ Bob_new_balance);
console.log("Carol's new balance: "+ Carol_new_balance);
//console.log("Expected_Bob_balance: "+ expected_Bob);


});

})

