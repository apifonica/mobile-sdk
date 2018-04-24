package com.aws.mobilesdkexample;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.TextView;

import com.scs.sdk.ICall;
import java.util.List;

public class CallArrayAdapter extends ArrayAdapter<ICall> {
    public CallArrayAdapter(@NonNull Context context, List<ICall> list) {
        super(context, R.layout.call_control, list);
    }

    class MyOnClickListener implements View.OnClickListener {
        @Override
        public void onClick(View view) {
            int id = view.getId();
            ICall call = (ICall)view.getTag();
            if ( call != null ) {
                if (id == R.id.endCall)
                    call.terminate();
                else if (id == R.id.holdCall)
                    call.pause();
                else if (id == R.id.resumeCall)
                    call.resume();
            }
        }
    }
    private MyOnClickListener m_clickListener = new MyOnClickListener();

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View view = null;
        if (convertView == null) {

            LayoutInflater inflator = ((Activity)getContext()).getLayoutInflater();
            view = inflator.inflate(R.layout.call_control, null);

            Button btn = (Button)view.findViewById(R.id.endCall);
            if ( btn != null )
                btn.setOnClickListener( m_clickListener );
            btn = (Button)view.findViewById(R.id.holdCall);
            if ( btn != null )
                btn.setOnClickListener( m_clickListener );
            btn = (Button)view.findViewById(R.id.resumeCall);
            if ( btn != null )
                btn.setOnClickListener( m_clickListener );
        } else
            view = convertView;

        ICall curCall = ((ICall)getItem(position));

        TextView tv = (TextView)view.findViewById(R.id.phoneNumber);
        if ( tv != null )
            tv.setText( curCall.getNumber() );
        Button btn = (Button)view.findViewById(R.id.endCall);
        if ( btn != null )
            btn.setTag( curCall );
        btn = (Button)view.findViewById(R.id.holdCall);
        if ( btn != null )
            btn.setTag( curCall );
        btn = (Button)view.findViewById(R.id.resumeCall);
        if ( btn != null )
            btn.setTag( curCall );

        return view;
    }
}
