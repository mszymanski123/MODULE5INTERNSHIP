
print_system_info() {
    echo "Report generated on: $(date)"
    echo "Current user: $USER"
    echo "Hostname: $(hostname)"
    echo "Internal IP address: $(hostname -I)"
    echo "External IP address: $(curl -s ifconfig.me)"
    echo "Linux distribution: $(lsb_release -d | cut -f2)"
    echo "System uptime: $(uptime -p)"
    echo "Disk usage:"
    df -h / | awk 'NR==2{print "  Used:", $3, "Free:", $4}'
    echo "RAM usage:"
    free -h | awk 'NR==2{print "  Total:", $2, "Free:", $4}'
    echo "CPU information:"
    echo "  Number of cores: $(nproc)"
    echo "  CPU frequency: $(lscpu | grep "CPU MHz" | awk '{print $3}') MHz"
}

print_system_info > report.txt
echo "Report generated. Please check 'report.txt'."

