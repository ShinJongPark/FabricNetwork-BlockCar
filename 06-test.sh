docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode invoke -o orderer001:7050 -C carchannel002 -n carSerial -c '{"Args":["registerCar","M12NAS22"]}'

docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode invoke -o orderer001:7050 -C carchannel002 -n car_002_Management -c '{"Args":["registerAccident","M12NAS22","TestData"]}'

docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode query -o orderer001:7050 -C carchannel001 -n carSerial -c '{"Args":["querySerial","M12NAS22"]}'
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode invoke -o orderer001:7050 -C carchannel001 -n carSerial -c '{"Args":["updateCarNumber","M12NAS22","77가1234"]}'
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode query -o orderer001:7050 -C carchannel001 -n carSerial -c '{"Args":["getCarHistory","M12NAS22"]}'


docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer chaincode list --instantiated -C carchannel001
