# Testing Guide for Odoo Mobile ERP Launcher

## 🧪 How to Test the Application

### Option 1: Test with Odoo Demo Server

The easiest way to test the app is using Odoo's official demo server:

1. **Launch the app** (currently running on Chrome)

2. **Enter Server URL**:
   ```
   https://demo.odoo.com
   ```

3. **Select Database**:
   - You should see a list of available demo databases
   - Select any database from the dropdown

4. **Login with Demo Credentials**:
   - Username: `admin`
   - Password: `admin`

   Or create a free trial at: https://www.odoo.com/trial

### Option 2: Test with Your Own Odoo Instance

If you have your own Odoo server:

1. **Enter your Odoo URL**:
   ```
   https://your-company.odoo.com
   ```
   Or your self-hosted URL:
   ```
   https://your-domain.com:8069
   ```

2. **Select your database**

3. **Login with your credentials**

## 📋 Test Cases

### Test Case 1: Server URL Validation
**Steps:**
1. Enter invalid URL: `not-a-url`
2. Click "Proceed"

**Expected Result:**
- ❌ Error message: "Please enter a valid URL"

**Steps:**
1. Enter valid URL: `https://demo.odoo.com`
2. Click "Proceed"

**Expected Result:**
- ✅ Navigate to database selection screen

---

### Test Case 2: Database List Loading
**Steps:**
1. After entering valid server URL
2. Wait for database list to load

**Expected Result:**
- ✅ Loading indicator appears
- ✅ Dropdown shows available databases
- ❌ If fails: Error message with retry button

---

### Test Case 3: Login Authentication
**Steps:**
1. Select a database
2. Click "Next"
3. Enter valid credentials
4. Click "Login"

**Expected Result:**
- ✅ Loading indicator appears
- ✅ Navigate to dashboard on success
- ❌ Error message if credentials invalid

---

### Test Case 4: Dashboard WebView
**Steps:**
1. After successful login
2. Wait for dashboard to load

**Expected Result:**
- ✅ Odoo web interface loads
- ✅ Can navigate through Odoo menus
- ✅ JavaScript works (interactive elements)
- ✅ Can access all Odoo features

---

### Test Case 5: Session Persistence
**Steps:**
1. Close the app (press 'q' in terminal)
2. Restart: `flutter run -d chrome`
3. Wait for splash screen

**Expected Result:**
- ✅ App should auto-login
- ✅ Navigate directly to dashboard
- ❌ If session expired: Go to server URL input

---

### Test Case 6: Logout Functionality
**Steps:**
1. In dashboard, click menu icon (top right)
2. Select "Logout"

**Expected Result:**
- ✅ Session cleared
- ✅ Navigate back to server URL input screen

---

### Test Case 7: Back Navigation
**Steps:**
1. Navigate to various Odoo pages
2. Press browser back button or use back gesture

**Expected Result:**
- ✅ Navigate back within Odoo interface first
- ✅ Only exit app when at main Odoo page

---

### Test Case 8: Error Handling - Invalid Server
**Steps:**
1. Enter non-existent URL: `https://invalid-odoo-server-12345.com`
2. Click "Proceed"

**Expected Result:**
- ❌ Error message: "Invalid Odoo server URL. Please check and try again."

---

### Test Case 9: Error Handling - Network Issues
**Steps:**
1. Disconnect internet
2. Try to proceed with any action

**Expected Result:**
- ❌ Error message about network connectivity
- ✅ Retry button available

---

### Test Case 10: Refresh Dashboard
**Steps:**
1. In dashboard, click refresh icon
2. Wait for reload

**Expected Result:**
- ✅ Loading indicator appears
- ✅ Dashboard reloads successfully

---

## 🎯 Quick Test Scenario

For a complete end-to-end test:

```bash
1. Launch: flutter run -d chrome
2. Enter: https://demo.odoo.com
3. Select: Any database from dropdown
4. Login: admin / admin
5. Navigate: Explore Odoo features in WebView
6. Test: Back navigation, refresh, logout
7. Close and reopen: Verify auto-login
```

## 🔍 What to Look For

### ✅ Success Indicators
- Smooth screen transitions
- Loading indicators during API calls
- Clear error messages
- Responsive UI
- No crashes or freezes
- Session persistence works
- WebView loads and functions correctly

### ❌ Issues to Report
- App crashes
- Blank screens
- API errors not handled
- WebView not loading
- Auto-login not working
- Memory leaks (check with DevTools)

## 🛠️ Debug Tools

### Flutter DevTools
Access at: http://127.0.0.1:61756/N85N3TAHOsY=/devtools/?uri=ws://127.0.0.1:61756/N85N3TAHOsY=/ws

Features:
- **Widget Inspector**: View widget tree
- **Performance**: Monitor FPS and rendering
- **Network**: View API calls
- **Logging**: See console output
- **Memory**: Check for memory leaks

### Hot Reload
While app is running, press:
- `r` - Hot reload (fast refresh)
- `R` - Hot restart (full restart)

## 📱 Testing on Different Platforms

### Android Device/Emulator
```bash
flutter run -d android
```

Test additional features:
- Hardware back button
- App switching
- Notifications (if implemented)
- File downloads (if Odoo requires)

### iOS Simulator (macOS only)
```bash
flutter run -d ios
```

Test additional features:
- Swipe gestures
- Safe area handling
- App lifecycle
- Permissions (if any)

### Windows Desktop
```bash
flutter run -d windows
```

Note: Requires Developer Mode enabled

### Web (Other Browsers)
```bash
flutter run -d edge
flutter run -d firefox
```

## 📊 Performance Testing

Check these metrics in DevTools:
- **Frame rendering**: Should be 60 FPS
- **Memory usage**: Should be stable (no leaks)
- **Network calls**: Should complete in reasonable time
- **App size**: Check final build size

## ✉️ Test with Different Odoo Versions

The app should work with:
- ✅ Odoo 14.0
- ✅ Odoo 15.0
- ✅ Odoo 16.0
- ✅ Odoo 17.0
- ✅ Odoo.com (SaaS)
- ✅ Self-hosted Odoo

## 🚨 Common Issues & Solutions

### Issue: Can't connect to server
**Solution**:
- Check internet connection
- Verify server URL is correct
- Ensure HTTPS is used
- Check if server is accessible from your network

### Issue: Database list empty
**Solution**:
- Server might not allow database listing
- Contact Odoo administrator
- Try using direct database name if known

### Issue: Login fails with valid credentials
**Solution**:
- Verify username/password
- Check if database name is correct
- Ensure account is active in Odoo
- Try logging in via web browser first

### Issue: WebView blank or not loading
**Solution**:
- Check internet connection
- Clear app data and retry
- Check browser console for errors
- Verify Odoo server is accessible

## 📝 Test Report Template

```
Test Date: ___________
Tester: ___________
Platform: [ ] Android [ ] iOS [ ] Web [ ] Windows
Device/Browser: ___________

Test Results:
[ ] Server URL Input: Pass / Fail
[ ] Database Selection: Pass / Fail
[ ] Login: Pass / Fail
[ ] Dashboard Load: Pass / Fail
[ ] Navigation: Pass / Fail
[ ] Session Persistence: Pass / Fail
[ ] Logout: Pass / Fail

Issues Found:
1. ___________
2. ___________

Overall Result: Pass / Fail
```

---

**Happy Testing!** 🎉

If you encounter any issues, check the console output and DevTools for detailed error messages.