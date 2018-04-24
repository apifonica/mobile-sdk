package com.aws.mobilesdkexample;

import android.content.pm.ActivityInfo;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TabHost;
import android.widget.TextView;

import com.scs.sdk.ActivationErrors;
import com.scs.sdk.CallErrors;
import com.scs.sdk.IActivationListener;
import com.scs.sdk.ICall;
import com.scs.sdk.ICallsListener;
import com.scs.sdk.SdkMobile;

import java.util.LinkedList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);

        SdkMobile.INSTANCE.initialize();

        setContentView(R.layout.activity_main);

        setTitle("SDKMobileExample");

        TabHost tabHost = (TabHost) findViewById(R.id.tabHost);

        tabHost.setup();

        TabHost.TabSpec tabSpec = tabHost.newTabSpec("tag1");

        tabSpec.setContent(R.id.tab1);
        tabSpec.setIndicator("Account");
        tabHost.addTab(tabSpec);

        tabSpec = tabHost.newTabSpec("tag2");
        tabSpec.setContent(R.id.tab2);
        tabSpec.setIndicator("Calls");
        tabHost.addTab(tabSpec);

        tabHost.setCurrentTab(0);

        Button button = findViewById(R.id.activateButton);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Button curBtn = (Button)findViewById(v.getId());
                if ( curBtn.getText().equals("Activate") )
                    SdkMobile.INSTANCE.getCallClient().activate(
                            ((TextView)findViewById(R.id.sipAccount)).getText().toString(),
                            ((TextView)findViewById(R.id.sipPassword)).getText().toString()
                    );
                else
                    SdkMobile.INSTANCE.getCallClient().deactivate();
            }
        });

        class ActivationListener implements IActivationListener {
            Button m_actBtn = null;
            ActivationListener(Button btn){ m_actBtn = btn; }
            @Override
            public void activated() {
                m_actBtn.setText("Deactivate");
            }
            @Override
            public void deactivated() {
                m_actBtn.setText("Activate");
            }
            @Override
            public void activationNone() {
                m_actBtn.setText("None activateion...");
            }
            @Override
            public void activationInProgress() {
                m_actBtn.setText("Activation in progress...");
            }
            @Override
            public void activationError(ActivationErrors error) {
                m_actBtn.setText("Activation error...");
            }
            @Override
            public void activationRefresh() {
                m_actBtn.setText("Activation refreshed");
            }
        }
        SdkMobile.INSTANCE.getCallClient().setActivationListener(new ActivationListener(button));


        //call
        button = findViewById(R.id.callToNumber);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                SdkMobile.INSTANCE.getCallClient().callToNumber(
                        ((TextView)findViewById(R.id.phoneNumber)).getText().toString()
                );
            }
        });

        ////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////
        CallArrayAdapter adapter = new CallArrayAdapter(this, new LinkedList<ICall>());
        ((ListView)findViewById(R.id.callsListView)).setAdapter(adapter);

        class CallsListener implements ICallsListener {
            private ArrayAdapter<ICall> m_adapter = null;
            private CallsListener(ArrayAdapter<ICall> adapter){
                m_adapter = adapter;
            }
            @Override
            public void callTrying(ICall iCall) {
                m_adapter.add(iCall);
                m_adapter.notifyDataSetChanged();
            }
            @Override
            public void callEstablished(ICall iCall) {
                m_adapter.notifyDataSetChanged();
            }
            @Override
            public void callPaused(ICall iCall) {
                m_adapter.notifyDataSetChanged();
            }
            @Override
            public void callResuming(ICall iCall) {
                m_adapter.notifyDataSetChanged();
            }
            @Override
            public void callResumed(ICall iCall) {
                m_adapter.notifyDataSetChanged();
            }
            @Override
            public void callTerminated(ICall iCall) {
                m_adapter.remove(iCall);
                m_adapter.notifyDataSetChanged();
            }
            @Override
            public void callError(ICall iCall, CallErrors callErrors) {
                m_adapter.remove(iCall);
                m_adapter.notifyDataSetChanged();
            }
            @Override
            public void callInConference(ICall iCall, boolean b) {
                m_adapter.notifyDataSetChanged();
            }
        }
        CallsListener cl = new CallsListener(adapter);
        SdkMobile.INSTANCE.getCallClient().setCallsListener(cl);

    }
}
