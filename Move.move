from flask import Flask, request, jsonify

app = Flask(__name__)

# Snotra referans sistemi için kullanıcı veritabanı örneği (gerçek bir veritabanı kullanılmalıdır).
users = {
    'user123': {
        'referral_code': 'ABCD123',
        'referral_count': 0
    }
}

# Endpoint for generating referral codes
@app.route('/generate_referral_code', methods=['POST'])
def generate_referral_code():
    user_id = request.json.get('user_id')
    
    # Generate a unique referral code (you can implement your own logic here)
    referral_code = generate_unique_referral_code()

    # Save the referral code to the user's profile in the database
    users[user_id]['referral_code'] = referral_code

    return jsonify({'referral_code': referral_code}), 200

# Endpoint for tracking referrals
@app.route('/track_referral', methods=['POST'])
def track_referral():
    referred_user_id = request.json.get('referred_user_id')
    
    # Increment referral count for the referring user
    referring_user_id = request.json.get('referring_user_id')
    users[referring_user_id]['referral_count'] += 1

    return jsonify({'message': 'Referral tracked successfully!'}), 200

if __name__ == '__main__':
    app.run(debug=True)
