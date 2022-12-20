# ZeroTier GitHub Action

ZeroTier is an SDN platform that allows users to create virtual
networks that can span multiple devices, locations, and cloud
providers.

The ZeroTier Github Action allows users to easily integrate
ZeroTier into their Github workflow by temporarily authorizing the
runner onto a private ZeroTier network.

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

