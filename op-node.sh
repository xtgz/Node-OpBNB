
set -ex

cd op-node-data

export L2_RPC=http://localhost:8551
# it's better to replace the L1_RPC with your own BSC Testnet RPC Endpoint for stability
export L1_RPC=https://data-seed-prebsc-1-s1.binance.org:8545
# replace the p2p private key with yours
# you can generate a new one with `openssl rand -hex 32`
export P2P_PRIV_KEY=0000000000000000000000000000000000000000000000000000000000000000
export P2P_BOOTNODES="enr:-J24QGQBeMsXOaCCaLWtNFSfb2Gv50DjGOKToH2HUTAIn9yXImowlRoMDNuPNhSBZNQGCCE8eAl5O3dsONuuQp5Qix2GAYjB7KHSgmlkgnY0gmlwhDREiqaHb3BzdGFja4PrKwCJc2VjcDI1NmsxoQL4I9wpEVDcUb8bLWu6V8iPoN5w8E8q-GrS5WUCygYUQ4N0Y3CCIyuDdWRwgiMr"

./op-node \
  --l1.trustrpc \
  --sequencer.l1-confs=15 \
  --verifier.l1-confs=15 \
  --l1.http-poll-interval 3s \
  --l1.epoch-poll-interval 45s \
  --l1.rpc-max-batch-size 20 \
  --rollup.config=./rollup.json \
  --rpc.addr=0.0.0.0 \
  --rpc.port=8546 \
  --p2p.sync.req-resp \
  --p2p.listen.ip=0.0.0.0 \
  --p2p.listen.tcp=9003 \
  --p2p.listen.udp=9003 \
  --snapshotlog.file=./snapshot.log \
  --p2p.priv.raw=$P2P_PRIV_KEY \
  --p2p.bootnodes=$P2P_BOOTNODES \
  --metrics.enabled \
  --metrics.addr=0.0.0.0 \
  --metrics.port=7300 \
  --pprof.enabled \
  --rpc.enable-admin \
  --l1=${L1_RPC} \
  --l2=${L2_RPC} \
  --l2.jwt-secret=./jwt.txt \
  --log.level=debug
