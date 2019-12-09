Example PowerShell Webhook Server
=================================

Uses [`webhook`][1] to start a webhook server. Demonstrates how to set up a webhook with an API key and an optional parameter. When the webhook is triggered, [`test-hook.ps1`][2] is executed and its output is returned to the user.

Hook configuration docs can be found [here][3].

To run the webhook server, just run [`run.ps1`][4]. Then in another terminal window, run:

```powershell
Invoke-RestMethod "http://localhost:9000/hooks/test-hook?apikey=9074aa54d80404921881b2dd382c5f3124234a020cfb63ed26678dc082926339&name=Phil"
```

[1]: https://github.com/adnanh/webhook
[2]: ./test-hook.ps1
[3]: https://github.com/adnanh/webhook/blob/master/docs/Hook-Definition.md
[4]: ./run.ps1
