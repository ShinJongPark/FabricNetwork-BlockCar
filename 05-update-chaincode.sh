if [ "$#" != 2 ]; then
    echo 'Incorrect number of arguments. Expecting 2, parameter { Name, version } '
else
    echo 'updating chaincode is actived.'
fi


# docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode package /var/hyperledger/chaincode/ccpack.out -n carSerial -v 0.2 -l node001 -p /var/hyperledger/chaincode/node001
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode package /var/hyperledger/chaincode/ccpack.out -n $1 -v $2 -l node -p /var/hyperledger/chaincode/node001

docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode install -n $1 -v $2 -l node -p /var/hyperledger/chaincode/node001
docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer chaincode install -n $1 -v $2 -l node -p /var/hyperledger/chaincode/node001
docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer chaincode install -n $1 -v $2 -l node -p /var/hyperledger/chaincode/node001



# nodejs chaincode instantiate
# 체인코드 도커 컨테이너를 생성 및 구동
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode upgrade -o orderer001:7050 -C carchannel001 -n $1 -v $2 -c '{"Args":["init"]}' -P "OR('carAssociationOrgMSP.member','carInsuranceOrgMSP.member','carMaintenanceOrgMSP.member')"



sleep 30

# 적용된 체인코드 리스트
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode list --instantiated -C carchannel001
