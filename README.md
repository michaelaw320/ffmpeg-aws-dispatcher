# ffmpeg-aws-dispatcher
Scripts to dispatch encoding job to AWS instance easily (from another server)

General idea:
Dedicated Server (with public IP) -> scp to AWS instance -> Encoding starts on AWS -> AWS instance push back the results to your server

Configuration is done on your server
