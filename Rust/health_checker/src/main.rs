fn main(){
    println!("🚀 Starting System Health Check...");

    let cpu_data = get_cpu_status();
    let (metric, load, is_healthy) = cpu_data;

    println!("---------------------------");
    println!("Metric: {}", metric);
    println!("Value: {}%", load);
    if is_healthy == true{
        println!("✅ Status: HEALTHY")
    }else{
        println!("🚨 Status: CRITICAL")
    }
    println!("Status Healthy?: {}", is_healthy);
    println!("---------------------------");
}

fn get_cpu_status() -> (&'static str, f64, bool) {
    let cpu_load = 34.5;
    let is_healthy = true; 

    ("CPU Load", cpu_load, is_healthy)
}