
(async () => {
    try {
        console.log('Running deployWithEthers script...')

        const contractName = 'Owner'
        const constructorArgs = []

        const artifactsPath = `browser/contracts/artifacts/${contractName}.json`

        const metadata = JSON.parse(await remix.call('fileManager', 'getFile', artifactsPath))
        const signer = (new ethers.providers.Web3Provider(web3Provider)).getSigner()

        let factory = new ethers.ContractFactory(metadata.abi, metadata.data.bytecode.object, signer);

        let contract = await factory.deploy(...constructorArgs);

        console.log('Contract Address: ', contract.address);

        await contract.deployed()
        console.log('Deployment successful.')
    } catch (e) {
        console.log(e.message)
    }
})()
