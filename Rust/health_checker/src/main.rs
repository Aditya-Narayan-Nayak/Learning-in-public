fn main(){
    println!("🚀 Starting System Health Check...");

    let cpu_data = get_cpu_status();

    let (metric, value, is_healthy) = cpu_data;

    println!("---------------------------");
    println!("Matric: {}", metric);
    println!("value: {}", value);
    println!("status_healthy: {}", is_healthy);
    println!("---------------------------");

}

fn get_cpu_status() -> (&'static str, f64, bool) {
    let cpu_load = 34.5;
    let is_okay = true;

    ("CPU data", cpu_load, is_okay)
}