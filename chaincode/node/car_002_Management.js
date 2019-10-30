const shim = require('fabric-shim');
const util = require('util');

var Chaincode = class {

    async Init(stub){
        console.info('Instantiated completed');
        return shim.success();
    }

    async Invoke(stub){
        let ret = stub.getFunctionAndParameters();
        console.info(ret);

        let method = this[ret.fcn];

        if(!method){
            console.log('Method name [' + ret.fcn + '] is not found');
            return shim.success();
        }

        try{
            let payload = await method(stub, ret.params);
            return shim.success(payload);
        }catch(err){
            console.log(err);
            return shim.error(err);
        }
    }

    /*
    Register Accident
    args[0]: carSerial Number
    args[1]: accident Date
    */
    async registerAccident(stub, args){
        console.info('======== Registration Accident ========');
        if(args.length != 2){
            throw new Error('Incorrect number of arguments. Expecting 2, but received ' + args.length);
        }

        let txTimestamp = stub.getTxTimestamp();
        let tsSec = txTimestamp.seconds;
        let tsSecValue = tsSec.low;
        let dataTimeObj = new Date(tsSecValue*1000);
        var timestampString = dataTimeObj.toISOString().replace(/T|Z|\.\d{3}/g, ' ').trim();

        var accidentInfo = {
            carSerialNumber: args[0],
            carData: args[1],
            createdAt: timestampString,
            expiredAt: 'False'
        };


        let compositeKey = stub.createCompositeKey("Accident.", [args[0]]);

        await stub.putState(compositeKey, Buffer.from(JSON.stringify(accidentInfo)));

        console.info('Accident is registered');
        console.info(accidentInfo);

    }

    /*
    Register Maintenance
    args[0]: carSerial Number
    args[1]: owner
    args[2]: Maintenance Data
    */
    async registerMaintenance(stub, args){
        console.info('======== Registration Maintenance ========');
        if(args.length != 2){
            throw new Error('Incorrect number of arguments. Expecting 2, but received ' + args.length);
        }

        let txTimestamp = stub.getTxTimestamp();
        let tsSec = txTimestamp.seconds;
        let tsSecValue = tsSec.low;
        let dataTimeObj = new Date(tsSecValue*1000);
        var timestampString = dataTimeObj.toISOString().replace(/T|Z|\.\d{3}/g, ' ').trim();

        var maintenanceInfo = {
            carSerialNumber: args[0],
            carData: args[1],
            createdAt: timestampString,
            expiredAt: 'False'
        };


        let compositeKey = stub.createCompositeKey("Maintenance.", [args[0]]);

        await stub.putState(compositeKey, Buffer.from(JSON.stringify(maintenanceInfo)));

        console.info('Maintenance is registered');
        console.info(maintenanceInfo);

    }

    /*
    Register Updated Owner
    args[0]: carSerial Number
    args[1]: owner
    */
    async RegisterUpdatedOwner(stub, args){
        console.info('======== Update Owner  ========');
        if(args.length != 2){
            throw new Error('Incorrect number of arguments. Expecting 2, but received ' + args.length);
        }

        let txTimestamp = stub.getTxTimestamp();
        let tsSec = txTimestamp.seconds;
        let tsSecValue = tsSec.low;
        let dataTimeObj = new Date(tsSecValue*1000);
        var timestampString = dataTimeObj.toISOString().replace(/T|Z|\.\d{3}/g, ' ').trim();

        var updatedOwnerInfo = {
            carSerialNumber: args[0],
            carData: args[1],
            createdAt: timestampString,
            expiredAt: 'False'
        };


        let compositeKey = stub.createCompositeKey("Owner.", [args[0]]);

        await stub.putState(compositeKey, Buffer.from(JSON.stringify(updatedOwnerInfo)));

        console.info('Updated owner');
        console.info(updatedOwnerInfo);

    }


    /*
    Get Accident History
    args[0] carSerialNumber
    */
    async getAccidentHistory(stub, args){

        console.info('======== GET Accident HISTORY ========');

        if(args.length != 1){
            throw new Error('Incorrect number of arguments. Expecting carSerialNumber as an argument');
        }

        let searchKey = stub.createCompositeKey("Accident.", [args[0]]);

        var historyIter = await stub.getHistoryForKey(searchKey);

        let results = [];
        let res = {done : false};

        while(!res.done){
            res = await historyIter.next();

            try{

                console.info('======= RES.VALUE.VALUE =======');
                console.info(res.value.value);

                if(res && res.value && res.value.value){
                    let val = res.value.value.toString('utf8');

                    if(val.length > 0){
                        results.push(JSON.parse(val));
                    }
                }

            }catch(err){
                console.info(err);
            }

            if(res && res.done){
                try{
                    historyIter.close();
                }catch(err){
                    console.info(err);
                }
            }
        }

        console.info(results);

        return Buffer.from(JSON.stringify(results));

    }

    /*
    Get Maintenance History
    args[0] carSerialNumber
    */
    async getMaintenanceHistory(stub, args){

        console.info('======== GET Maintenance HISTORY ========');

        if(args.length != 1){
            throw new Error('Incorrect number of arguments. Expecting carSerialNumber as an argument');
        }

        let searchKey = stub.createCompositeKey("Maintenance.", [args[0]]);

        var historyIter = await stub.getHistoryForKey(searchKey);

        let results = [];
        let res = {done : false};

        while(!res.done){
            res = await historyIter.next();

            try{

                console.info('======= RES.VALUE.VALUE =======');
                console.info(res.value.value);

                if(res && res.value && res.value.value){
                    let val = res.value.value.toString('utf8');

                    if(val.length > 0){
                        results.push(JSON.parse(val));
                    }
                }

            }catch(err){
                console.info(err);
            }

            if(res && res.done){
                try{
                    historyIter.close();
                }catch(err){
                    console.info(err);
                }
            }
        }

        console.info(results);

        return Buffer.from(JSON.stringify(results));

    }

    /*
    Get Owner History
    args[0] carSerialNumber
    */
    async getOwnerHistory(stub, args){

        console.info('======== GET Owner HISTORY ========');

        if(args.length != 1){
            throw new Error('Incorrect number of arguments. Expecting carSerialNumber as an argument');
        }

        let searchKey = stub.createCompositeKey("Owner.", [args[0]]);

        var historyIter = await stub.getHistoryForKey(searchKey);

        let results = [];
        let res = {done : false};

        while(!res.done){
            res = await historyIter.next();

            try{

                console.info('======= RES.VALUE.VALUE =======');
                console.info(res.value.value);

                if(res && res.value && res.value.value){
                    let val = res.value.value.toString('utf8');

                    if(val.length > 0){
                        results.push(JSON.parse(val));
                    }
                }

            }catch(err){
                console.info(err);
            }

            if(res && res.done){
                try{
                    historyIter.close();
                }catch(err){
                    console.info(err);
                }
            }
        }

        console.info(results);

        return Buffer.from(JSON.stringify(results));

    }

    // args[0]: carSerialNumber
    // async expireCarAccidentData(stub, args){
    //     console.info('======== EXPIRE CarSerial ========');
    //
    //     let searchKey = stub.createCompositeKey("Accident.", [args[0]]);
    //
    //     let car = await stub.getState(searchKey);
    //     let carInfo = JSON.parse(car);
    //
    //     try{
    //         console.info('carInfo.carSerialNumber   ===== : ', carInfo.carSerialNumber);
    //         console.info('carInfo.carData     ===== : ', carInfo.carData);
    //         console.info('carInfo.createdAt ===== : ', carInfo.createdAt);
    //         console.info('carInfo.expiredAt ===== : ', carInfo.expiredAt);
    //     }catch(err){
    //         console.info(err);
    //     }
    //
    //     let txTimestamp = stub.getTxTimestamp();
    //     let tsSec = txTimestamp.seconds;
    //     let tsSecValue = tsSec.low;
    //     let dataTimeObj = new Date(tsSecValue*1000);
    //     var timestampString = dataTimeObj.toISOString().replace(/T|Z|\.\d{3}/g, ' ').trim();
    //     console.info(timestampString);
    //
    //     assetInfo.expiredAt = timestampString;
    //
    //     await stub.putState(searchKey, Buffer.from(JSON.stringify(carInfo)));
    //
    // }

    //args[0]: carSerialNumber
    async queryOwner(stub, args){
        console.info('======== QUERY ========');

        let searchKey = stub.createCompositeKey("Owner.", [args[0]]);

        let onwerInfo = await stub.getState(searchKey);
        console.info("Current Owner");
        console.info(onwerInfo);

        return onwerInfo;
    }

};

shim.start(new Chaincode());
