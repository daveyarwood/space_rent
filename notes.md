Two Heroku Scheduler jobs:

Daily at 3:00 AM UTC:

```
if [ "$(date +%d)" = 25 ]; then rake rent:monthly; fi
```

Daily at 3:30 AM UTC:

```
if [ "$(date +%d)" = 05 ]; then rake rent:late; fi
```
