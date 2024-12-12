oc edit dnses.operator.openshift.io

spec:
  cache:
    negativeTTL: 0s
    positiveTTL: 0s
  logLevel: Normal
  nodePlacement: {}
  operatorLogLevel: Normal
  servers:
    - forwardPlugin:
        policy: RoundRobin
        upstreams:
          - 192.168.69.18
          - 192.168.69.18
      name: ns1.
      zones:
        - mtv.changeme
  upstreamResolvers:
    policy: Sequential
    protocolStrategy: ''
    transportConfig: {}
    upstreams:
      - port: 53
        type: SystemResolvConf