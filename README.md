# ffmpeg-aws-dispatcher
Scripts to dispatch encoding job to AWS instance easily (from another server)

General idea:
Dedicated Server (with public IP) -> scp to AWS instance -> Encoding starts on AWS -> AWS instance push back the results to your server

Configuration is done on your server

Prerequisite:
  - A server with public IP and SSH authentication via key enabled (and you have the key)
  - AWS EC2 Instance

How to use:
  - Download the static binary (linux binary) of ffmpeg and put it on 'ffmpeg-bin' folder and name it 'ffmpeg'
  - Perform necessary chmod to executables ('ffmpeg', 'StartEncoding.sh', 'EC2EncodeExec.sh', scripts in 'Script' folder)
  - Rename 'config_template.sh' to 'config.sh'
  - Fill in the server configuration on 'config.sh'
  - Configure the encoder options in 'EncoderConfiguration.txt'
  - Place the media that will be encoded to 'SourceMedia' folder
  - Empty your Result folder (but the folder) else everything inside the 'Result' folder will be copied back to your server
  - Put the file names (including extension) to the 'InputFiles.txt'
  - Specify the output name of the result in 'OutputFiles.txt' (first line will correspond with first line of input file name and so on)
  - Script named 'GenerateIONames.sh' can help generate Input and Output name
  - Execute the script 'StartEncoding.sh' to start the whole process
  - You can end your ssh session, and wait until the file appears on the Result folder (AWS will shutdown on complete)
  
Future plans:
  - Email notification on completion (any other notification may work as well)
  - Executes some post scripts if desired

Development hints:
  - Script that will be executed on remote machine: 'EC2EncodeExec.sh'
  - If you wish to add additional encoding option, recipes are all in the Scripts folder
  - Execute flow:
    - Server ('StartEncoding.sh') -> AWS ('EC2EncodeExec.sh')
    - on AWS:
      - Main encoder script ('MainEncodeScript.sh') will read the 'InputFiles.txt', 'EncoderConfiguration.txt', and will pass the execution to the specific encoding script based on video codec (H264/H265/etc.)
      - Specific encoder script will execute the ffmpeg and start encoding
    - on Finish:
      - ('EC2EncodeExec.sh') will push all the 'Result' folder to your server with scp
