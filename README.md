# ZeroTier GitHub Action

ZeroTier is an SDN platform that allows users to create virtual
networks that can span multiple devices, locations, and cloud
providers. ZeroTier creates an encrypted peer-to-peer mesh overlay
network that handles NAT traversal, authentication, and authorization
to network resources.

The ZeroTier Github Action allows users to easily integrate
ZeroTier into their Github workflow by temporarily joining and
authorizing workflow runner onto a private ZeroTier network.

```
- name: ZeroTier
  uses: zerotier/github-action@v1
  with:
    network_id: ${{ secrets.ZEROTIER_NETWORK_ID }}
    auth_token: ${{ secrets.ZEROTIER_CENTRAL_TOKEN }}
```

`ZEROTIER_CENTRAL_TOKEN` can be provisioned from `Account` section in the [ZeroTier Central](https://my.zerotier.com) admin panel.

This Action works on Ubuntu, MacOS, and Windows runners.

----

This action installs ZeroTier on the runner node and generates a unique ZeroTier identity.  
It then uses the supplied `auth_token` to authorize the runner onto the network.

```
- name: ZeroTier
  uses: zerotier/github-action@v1
  with:
    network_id: ${{ secrets.ZEROTIER_NETWORK_ID }}
    auth_token: ${{ secrets.ZEROTIER_CENTRAL_TOKEN }}
    
- name: ping host
  shell: bash
  run: |
    count=10
    while ! ping -c 1 ${{ secrets.ZEROTIER_HOST_IP }} ; do
      echo "waiting..." ;
      sleep 1 ;
      let count=count-1
    done
    echo "ping success"
```

This action uses a Post step to deauthorize the runner at the end of
the job.
