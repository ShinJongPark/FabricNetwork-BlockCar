# channel create
# 피어들끼리 통신할 채널 생성
## 차량 시리얼 관리 채널
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel create -o orderer001:7050 -c carchannel001 -f /var/hyperledger/production/carchannel001.tx --outputBlock /var/hyperledger/production/carchannel001-genesis.block
## 차량 이력 관리 채널
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel create -o orderer001:7050 -c carchannel002 -f /var/hyperledger/production/carchannel002.tx --outputBlock /var/hyperledger/production/carchannel002-genesis.block

# 각 피어들 채널 Join
## 차량 시리얼 관리 채널
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel fetch config /var/hyperledger/production/carchannel001-genesis.block -o orderer001:7050 -c carchannel001
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel join -o orderer001:7050 -b /var/hyperledger/production/carchannel001-genesis.block

docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer channel fetch config /var/hyperledger/production/carchannel001-genesis.block -o orderer001:7050 -c carchannel001
docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer channel join -o orderer001:7050 -b /var/hyperledger/production/carchannel001-genesis.block

docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer channel fetch config /var/hyperledger/production/carchannel001-genesis.block -o orderer001:7050 -c carchannel001
docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer channel join -o orderer001:7050 -b /var/hyperledger/production/carchannel001-genesis.block

# 차량 이략 관리 채널
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel fetch config /var/hyperledger/production/carchannel002-genesis.block -o orderer001:7050 -c carchannel002
docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel join -o orderer001:7050 -b /var/hyperledger/production/carchannel002-genesis.block

docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer channel fetch config /var/hyperledger/production/carchannel002-genesis.block -o orderer001:7050 -c carchannel002
docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer channel join -o orderer001:7050 -b /var/hyperledger/production/carchannel002-genesis.block

docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer channel fetch config /var/hyperledger/production/carchannel002-genesis.block -o orderer001:7050 -c carchannel002
docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer channel join -o orderer001:7050 -b /var/hyperledger/production/carchannel002-genesis.block
