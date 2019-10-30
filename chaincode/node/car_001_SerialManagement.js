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

    // args[0]: carSerialNumber
    async registerCar(stub, args){
        console.info('======== Registration Car ========');
        if(args.length != 1){
            throw new Error('Incorrect number of arguments. Expecting 1, but received ' + args.length);
        }

        let txTimestamp = stub.getTxTimestamp();
        let tsSec = txTimestamp.seconds;
        let tsSecValue = tsSec.low;
        let dataTimeObj = new Date(tsSecValue*1000);
        var timestampString = dataTimeObj.toISOString().replace(/T|Z|\.\d{3}/g, ' ').trim();


        var carInfo = {
            carSerialNumber: args[0],
            carNumber: 'False',
            createdAt: timestampString,
            expiredAt: 'False'
        };


        let compositeKey = stub.createCompositeKey("Car.", [args[0]]);

        await stub.putState(compositeKey, Buffer.from(JSON.stringify(carInfo)));

        console.info('Car is registered');
        console.info(carInfo);

    }

    //args[0] carSerialNumber
    async getCarHistory(stub, args){

        console.info('======== GET Car HISTORY ========');

        if(args.length != 1){
            throw new Error('Incorrect number of arguments. Expecting carSerialNumber as an argument');
        }

        let searchKey = stub.createCompositeKey("Car.", [args[0]]);

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
    async expireCarSerial(stub, args){
        console.info('======== EXPIRE CarSerial ========');

        let searchKey = stub.createCompositeKey("Car.", [args[0]]);

        let car = await stub.getState(searchKey);
        let carInfo = JSON.parse(car);

        try{
            console.info('carInfo.carSerialNumber   ===== : ', carInfo.carSerialNumber);
            console.info('carInfo.carNumber     ===== : ', carInfo.carNumber);
            console.info('carInfo.createdAt ===== : ', carInfo.createdAt);
            console.info('carInfo.expiredAt ===== : ', carInfo.expiredAt);
        }catch(err){
            console.info(err);
        }

        let txTimestamp = stub.getTxTimestamp();
        let tsSec = txTimestamp.seconds;
        let tsSecValue = tsSec.low;
        let dataTimeObj = new Date(tsSecValue*1000);
        var timestampString = dataTimeObj.toISOString().replace(/T|Z|\.\d{3}/g, ' ').trim();
        console.info(timestampString);

        assetInfo.expiredAt = timestampString;

        await stub.putState(searchKey, Buffer.from(JSON.stringify(carInfo)));

    }

    // args[0]: carSerialNumber(string)
    // args[1]: new carNumber(string)
    async updateCarNumber(stub, args){
        console.info('======== UPDATE CarNumber ========');

        if(args.length != 2){
            throw new Error('Incorrect number of arguments. Expecting 2, but received' + args.length);
        }


        let searchKey = stub.createCompositeKey("Car.", [args[0]]);

        let updatedCarNumber = await stub.getState(searchKey);
        let updatedCarInfo = JSON.parse(updatedCarNumber);

        try{
          console.info('carSerialNumber  ===== : ', updatedCarInfo.carSerialNumber);
          console.info('carNumber        ===== : ', updatedCarInfo.carNumber);
          console.info('createdAt        ===== : ', updatedCarInfo.createdAt);
          console.info('expiredAt        ===== : ', updatedCarInfo.expiredAt);
        }catch(err){
            console.info(err);
        }

        let txTimestamp = stub.getTxTimestamp();
        let tsSec = txTimestamp.seconds;
        let tsSecValue = tsSec.low;
        let dataTimeObj = new Date(tsSecValue*1000);
        var timestampString = dataTimeObj.toISOString().replace(/T|Z|\.\d{3}/g, ' ').trim();
        console.info(timestampString);

        updatedCarInfo.carNumber = args[1];
        updatedCarInfo.createdAt = timestampString;
        updatedCarInfo.expiredAt = 'FALSE'


        console.info('Car updated');
        console.info(updatedCarInfo);

        await stub.putState(searchKey, Buffer.from(JSON.stringify(updatedCarInfo)));

    }

    //args[0]: carSerialNumber
    async query(stub, args){
        console.info('======== QUERY ========');

        let searchKey = stub.createCompositeKey("Car.", [args[0]]);

        let carInfo = await stub.getState(searchKey);

        console.info(carInfo);

        return carInfo;
    }

};

shim.start(new Chaincode());
