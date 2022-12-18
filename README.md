# ZeroTier GitHub Action

This Github Action connects to a [ZeroTier Network](https://www.zerotier.com).

```
- name: ZeroTier
  uses: zerotier/github-action@v1
  with:
    network_id: ${{ secrets.ZEROTIER_NETWORK_ID }}
    auth_token: ${{ secrets.ZEROTIER_CENTRAL_TOKEN }}
```

`ZEROTIER_CENTRAL_TOKEN` can be provisioned from `Account` section in the [ZeroTier Central](https://my.zerotier.com) admin panel.

This Action works on Ubuntu, MacOS, and Windows runners.
