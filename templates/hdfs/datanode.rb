Eye.application 'hdfs-datanode-{{ env_name }}' do
  working_dir '/etc/eye'
  stdall '/var/log/eye/hdfs-datanode-{{ env_name }}-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
#  Don't terminate on high CPU utilization
#  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes
  uid "{{ hadoop_user }}"

  process :datanode_{{ env_name }} do
    pid_file '{{ hadoop_var_prefix }}/hdfs_datanode.pid'
    start_command '{{ hadoop_distr_prefix }}/bin/hdfs datanode'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
