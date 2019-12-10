Example PowerShell Webhook Server
=================================

Uses [`webhook`][1] to start a webhook server. Demonstrates how to set up a webhook with an API key and an optional parameter. When the webhook is triggered, [`test-hook.ps1`][2] is executed and its output is returned to the user.

Hook configuration docs can be found [here][3].

To run the webhook server, just run [`run.ps1`][4]. Then in another terminal window, run:

```powershell
Invoke-RestMethod "http://localhost:9000/hooks/test-hook?apikey=9074aa54d80404921881b2dd382c5f3124234a020cfb63ed26678dc082926339&name=Phil"
```

Security
--------

I do not trust my PowerShell coding abilities, nor PowerShell itself, to be 100% confident that this is actually secure. Use your own best judgment, and use at your own risk. That said...

* Avoid passing parameters to the PowerShells script in `hook.json` via the command line! This is _incredibly_ easy to mess up and allows remote users to execute arbitrary commands.* It opens the door for injection attacks, similar to SQL injection, but far worse.
* To help prevent timing attacks, we've implemented the API key check in the actual PowerShell script. [Don't use the `match` trigger rule][5] documented in `webhook` docs.
* If you connect this to the Internet, modify this so it uses HTTPS. And you might consider putting it behind a reverse proxy like Nginx.
* Don't return error messages to the user when the script fails. PowerShell failure messages reveal too many details about the inner workings and organization of the server that this is running on.

_* The [first implementation of this][6] was vulnerable to command-line injection attacks. As an example, I was able to trick the hook server to create a "pwnd.txt" file using this URL: `http://localhost:9000/hooks/test-hook?name=Phil%20-ApiKey%20[ACTUAL_API_KEY_HERE]%3B%22you%27ve%20been%20pwned%22%20%3E%20pwnd.txt%3B%23&apikey=anything`_

[1]: https://github.com/adnanh/webhook
[2]: ./test-hook.ps1
[3]: https://github.com/adnanh/webhook/blob/master/docs/Hook-Definition.md
[4]: ./run.ps1
[5]: https://github.com/adnanh/webhook/issues/364
[6]: https://github.com/pcrockett-pathway/WebhookPowerShellExample/tree/726eb26775827e194ea08a24fe8cc9ac1cc71e36
