// Description: we will create a transaction decoder for the crupto currency using rust

fn read_version(hex: &str) -> u32 {
    return 1;
}

fn main() {
    let version = read_version("0x00000001");
    println!("version: {}", version);
}
