docker exec -it prometheus sh

tee -a /etc/prometheus/prometheus.yml <<EOF
- job_name: jenkins                                                                            
    metrics_path: /prometheus                                                                    
    static_configs:                                                                              
      - targets: ['34.64.255.99:32344'] # 젠킨스 주소가 타겟이 되도록
EOF