# Test Credentials for Odoo Mobile ERP Launcher

## 🔐 Test Server Information

### Server Details
- **Server URL**: `https://vmi3035083.contaboserver.net`
- **Database Name**: `test`
- **Username**: `test`
- **Password**: `test`

## 📝 Testing Instructions

### Step-by-Step Test Process

1. **Open the Application**
   - The app should now be running in Chrome browser
   - You'll see the Splash Screen first

2. **Enter Server URL**
   - When prompted, enter: `https://vmi3035083.contaboserver.net`
   - Click "Proceed"
   - Wait for validation

3. **Select Database**
   - You should see a dropdown with available databases
   - Select: `test`
   - Click "Next"

4. **Login**
   - Username: `test`
   - Password: `test`
   - Click "Login"

5. **Access Dashboard**
   - After successful login, you'll see the Odoo ERP interface in WebView
   - You can now navigate through all Odoo features

## ✅ What to Test

### 1. Server URL Input Screen
- [ ] URL validation works
- [ ] "Proceed" button functionality
- [ ] Error handling for invalid URLs
- [ ] Loading indicator appears

### 2. Database Selection Screen
- [ ] Database list loads from server
- [ ] "test" database appears in dropdown
- [ ] Can select "test" database
- [ ] "Next" button works
- [ ] Error handling if server unreachable

### 3. Login Screen
- [ ] Username field accepts input
- [ ] Password field is masked
- [ ] Password visibility toggle works
- [ ] "Login" button functionality
- [ ] Loading indicator during login
- [ ] Error message for wrong credentials
- [ ] Success: Navigate to dashboard

### 4. Dashboard Screen
- [ ] WebView loads Odoo interface
- [ ] JavaScript functionality works
- [ ] Can navigate within Odoo
- [ ] Refresh button works
- [ ] Menu items are accessible
- [ ] Back navigation works properly
- [ ] Logout function works

### 5. Session Management
- [ ] Close app and reopen
- [ ] Should auto-login with saved credentials
- [ ] Direct navigation to dashboard
- [ ] Session cookies preserved

### 6. Error Handling
- [ ] Network errors show appropriate messages
- [ ] Invalid credentials show error
- [ ] Server unreachable shows error
- [ ] All errors have retry options

## 🧪 Test Scenarios

### Scenario 1: First Time User
```
1. Launch app → See splash screen
2. No saved credentials → Go to server input
3. Enter server URL → Validate and proceed
4. Select database → Load list and select
5. Login with credentials → Authenticate
6. Access dashboard → Full Odoo interface
```

### Scenario 2: Returning User (Auto-Login)
```
1. Launch app → See splash screen
2. Saved credentials exist → Auto-login attempt
3. Success → Direct to dashboard
4. Failure → Back to server input
```

### Scenario 3: Logout and Re-login
```
1. In dashboard → Click menu
2. Select "Logout" → Clear session
3. Back to server input → Start fresh
4. Can login again with same or different credentials
```

## 📊 Expected Results

### Server Connection
- ✅ Server URL should connect successfully
- ✅ HTTPS connection should work
- ✅ Server should respond with database list

### Authentication
- ✅ test/test credentials should authenticate
- ✅ Session should be created
- ✅ Session cookies should be saved

### Dashboard
- ✅ Odoo web interface should load
- ✅ All Odoo features should be accessible
- ✅ Navigation should work smoothly

## 🐛 Known Issues to Check

1. **SSL Certificate**: If server has self-signed certificate, may need additional configuration
2. **CORS Issues**: Web version might have CORS restrictions
3. **Network Latency**: Check loading times
4. **Session Timeout**: Test what happens when session expires

## 📱 Testing on Different Platforms

### Web (Chrome) - Currently Running ✅
```bash
flutter run -d chrome
```

### Android (if available)
```bash
flutter run -d android
```
Test additional:
- Hardware back button
- App backgrounding/foregrounding

### iOS (if available on macOS)
```bash
flutter run -d ios
```
Test additional:
- Swipe gestures
- App lifecycle

## 🔍 Debug Information

If issues occur, check:

1. **Console Output**: Look for error messages in terminal
2. **Network Tab**: Check API calls in DevTools
3. **Flutter Inspector**: View widget tree
4. **Server Logs**: Check Odoo server logs for authentication errors

## 📝 Test Report Template

```
Test Date: 2026-02-06
Tester: [Your Name]
Platform: Chrome Web Browser
Server: https://vmi3035083.contaboserver.net

Test Results:
✅ / ❌  Server URL Input
✅ / ❌  Server Validation
✅ / ❌  Database List Loading
✅ / ❌  Database Selection (test)
✅ / ❌  Login Screen
✅ / ❌  Authentication (test/test)
✅ / ❌  Dashboard Loading
✅ / ❌  Odoo Interface Navigation
✅ / ❌  Session Persistence
✅ / ❌  Auto-Login
✅ / ❌  Logout Function
✅ / ❌  Error Handling

Issues Found:
1. _________________________
2. _________________________

Notes:
_________________________
_________________________

Overall Result: ✅ PASS / ❌ FAIL
```

## 🚀 Quick Test Command

The app is now running! Look for the Chrome browser window that opened automatically.

**Testing Flow:**
1. Server URL: `https://vmi3035083.contaboserver.net`
2. Database: `test`
3. Username: `test`
4. Password: `test`

**Expected Outcome:** You should be able to access your Odoo ERP system and navigate through all features!

---

**Note**: Please test the application now and report any issues you encounter. The app should successfully connect to your Odoo server and allow you to access all ERP features.