
# 트랜잭션 파일 생성 및 배포
## 차량 시리얼 관리 채널
./configtxgen -profile CarSerialChannel -outputAnchorPeersUpdate carAssociationOrgAnchor001.tx -channelID carchannel001 -asOrg carAssociationOrgMSP
./configtxgen -profile CarSerialChannel -outputAnchorPeersUpdate carInsuranceOrgAnchor001.tx -channelID carchannel001 -asOrg carInsuranceOrgMSP
./configtxgen -profile CarSerialChannel -outputAnchorPeersUpdate carMaintenanceOrgAnchor001.tx -channelID carchannel001 -asOrg carMaintenanceOrgMSP
# 
## 차량 이력 관리 채널
./configtxgen -profile CarChannel -outputAnchorPeersUpdate carAssociationOrgAnchor002.tx -channelID carchannel002 -asOrg carAssociationOrgMSP
./configtxgen -profile CarChannel -outputAnchorPeersUpdate carInsuranceOrgAnchor002.tx -channelID carchannel002 -asOrg carInsuranceOrgMSP
./configtxgen -profile CarChannel -outputAnchorPeersUpdate carMaintenanceOrgAnchor002.tx -channelID carchannel002 -asOrg carMaintenanceOrgMSP

mv carAssociationOrgAnchor001.tx ./channel-artifacts
mv carInsuranceOrgAnchor001.tx ./channel-artifacts
mv carMaintenanceOrgAnchor001.tx ./channel-artifacts

mv carAssociationOrgAnchor002.tx ./channel-artifacts
mv carInsuranceOrgAnchor002.tx ./channel-artifacts
mv carMaintenanceOrgAnchor002.tx ./channel-artifacts

# update anchor peer

docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel update -o orderer001:7050 -c carchannel001 -f /var/hyperledger/production/carAssociationOrgAnchor001.tx
docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer channel update -o orderer001:7050 -c carchannel001 -f /var/hyperledger/production/carInsuranceOrgAnchor001.tx
docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer channel update -o orderer001:7050 -c carchannel001 -f /var/hyperledger/production/carMaintenanceOrgAnchor001.tx

#
# docker exec -e "CORE_PEER_LOCALMSPID=carAssociationOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carAssociationOrg peer channel update -o orderer001:7050 -c carchannel002 -f /var/hyperledger/production/carAssociationOrgAnchor002.tx
# docker exec -e "CORE_PEER_LOCALMSPID=carInsuranceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carInsuranceOrg peer channel update -o orderer001:7050 -c carchannel002 -f /var/hyperledger/production/carInsuranceOrgAnchor002.tx
# docker exec -e "CORE_PEER_LOCALMSPID=carMaintenanceOrgMSP" -e "CORE_PEER_MSPCONFIGPATH=/var/hyperledger/users/msp" peer0.carMaintenanceOrg peer channel update -o orderer001:7050 -c carchannel002 -f /var/hyperledger/production/carMaintenanceOrgAnchor002.tx
