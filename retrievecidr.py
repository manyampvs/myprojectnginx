import requests

# Replace 'FDQN/vend_ip' with the actual endpoint URL
endpoint_url = 'https://FDQN/vend_ip'

# Define query parameters
params = {
    'ip_address': '192.168.0.0',
    'subnet_size': '16'
}

try:
    # Send GET request to the API endpoint
    response = requests.get(endpoint_url, params=params)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Extract CIDR information from the response
        cidr_info = response.json()

        # Print or process the CIDR information as needed
        print("CIDR Information:")
        print("CIDR:", cidr_info['cidr'])
        print("Netmask:", cidr_info['netmask'])
        print("Subnet:", cidr_info['subnet'])
    else:
        print("Error:", response.status_code, response.text)

except requests.RequestException as e:
    print("Error:", e)
