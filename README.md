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

This a tion 
