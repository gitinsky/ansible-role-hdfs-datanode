Eye.application 'hdfs-datanode' do
  working_dir '/etc/eye'
  stdall '/var/log/eye/hdfs-datanode-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :datanode do
    pid_file '/var/hadoop/hdfs_datanode.pid'
    start_command 'sudo -u hadoop /opt/hadoop/bin/hdfs datanode'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
